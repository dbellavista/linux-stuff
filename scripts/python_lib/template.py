#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#

import argparse
import shutil
import os
import colorlog


def apply_template(cl, dst, author, name, description):
    desc = description
    if description is None:
        desc = name

    for pn in os.listdir(dst):
        path = os.path.join(dst, pn)

        if os.path.isdir(path):
            apply_template(cl, path, author, name, description)
            continue

        try:
            with open(path) as f:
                data = f.read()
        except Exception as e:
            print(cl.warning('Error reading {0}: {1}'.format(path, e)))
            continue

        data = data.replace('%PRJ_NAME%', name)
        data = data.replace('%PRJ_AUTHOR%', author)
        data = data.replace('%PRJ_DESCRIPTION%', desc)

        try:
            with open(path, 'w') as f:
                f.write(data)
        except Exception as e:
            print(cl.fail('Error writing {0}: {1}'.format(path, e)))
            continue


def main():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter,
        description='Template applier')
    parser.add_argument('template', help='The template to apply')
    parser.add_argument('-a', '--author', help='Author', required=True)
    parser.add_argument(
        '-p', '--project-name', help='Project name', required=True)
    parser.add_argument('-d', '--description', default=None,
                        help='Description')
    args = parser.parse_args()

    cl = colorlog.ColorLog()

    p = os.path.join(os.environ['STUFF'], 'templates', args.template)

    if not os.path.exists(p):
        print(cl.fail('Template {0} doesn\'t exists'.format(args.template)))
        return
    dest = os.path.join(os.getcwd(), args.project_name)
    try:
        shutil.copytree(p, dest)
    except Exception as e:
        print(cl.fail('Error creating template: {0}'.format(e)))
        return

    apply_template(cl, dest, args.author, args.project_name, args.description)

    print(cl.succeed('Project {0} created!'.format(args.project_name)))


if __name__ == '__main__':
    main()
