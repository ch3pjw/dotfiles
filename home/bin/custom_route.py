#!/usr/bin/env python

from __future__ import print_function
import argh
import subprocess
import socket
import re

default_interface = 'wlan0'

ipv4_regex = '\d+(?:\.\d+){3}'


def _get_gateway_ip(interface):
    nmcli_output = subprocess.check_output(
        ('nmcli', 'dev', 'list', 'iface', interface)).decode()
    match = re.search(
        '^DHCP\d\.OPTION.*routers = ({ipv4_regex})'.format(
            ipv4_regex=ipv4_regex),
        nmcli_output, re.MULTILINE)
    if match:
        return match.group(1)


def _route_exists(host_ip, interface):
    ip_route_output = subprocess.check_output(('ip', 'route')).decode()
    regex = '^{host_ip}.*{interface}'.format(
        host_ip=host_ip, interface=interface)
    return bool(re.search(regex, ip_route_output, re.MULTILINE))


def _do_route(action, host_ip, gateway_ip):
    subprocess.check_call(
        ('sudo', 'route', action, '-host', host_ip, 'gw', gateway_ip))


def _common(action, noop_check, noop_msg, op_msg, host_name, interface):
    host_ip = socket.gethostbyname(host_name)
    if noop_check(host_ip, interface):
        print(noop_msg.format(**locals()))
    else:
        gateway_ip = _get_gateway_ip(interface)
        if gateway_ip:
            print(op_msg.format(**locals()))
            _do_route(action, host_ip, gateway_ip)
        else:
            raise ValueError('Could not find gateway IP')


def add(host_name, interface=default_interface):
    '''Add a custom route to the given host via the given interface'''
    noop_msg = (
        '{interface} route to {host_name!r} ({host_ip}) already in place')
    op_msg = (
        'Setting the default gateway for {host_name!r} ({host_ip}) to '
        '{gateway_ip} ({interface})')
    _common('add', _route_exists, noop_msg, op_msg, host_name, interface)


def delete(host_name, interface=default_interface):
    '''Remove a custom route to the given host via the given interface
    '''
    noop_msg = 'No existing alternate route to {host_name!r} ({host_ip})'
    op_msg = (
        'Deleting the custom route for {host_name!r} ({host_ip})')
    _common(
        'del', lambda *a: not _route_exists(*a), noop_msg, op_msg, host_name,
        interface)

if __name__ == '__main__':
    parser = argh.ArghParser()
    parser.add_commands((add, delete))
    parser.dispatch()
