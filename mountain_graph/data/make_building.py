# -*- coding: utf-8 -*-

import sqlite3

sql = " SELECT id, address FROM shop WHERE address LIKE '%{floor}%'"

result_dict = {}


def main():
    conn = sqlite3.connect('shops.db')
    c = conn.cursor()
    try:
        for i in range(1, 300):
            for j in ['F', '階']:
                c.execute(sql.format(floor=str(i) + j))
                set_dict(c.fetchall(), i)
    finally:
        conn.close()

    for k, v in result_dict.iteritems():
        print 'INSERT INTO building (shop_id, story) VALUES ({}, {});'.format(k, v)


def set_dict(data, floor):
    for rec in data:
        shop_id, a = rec
        result_dict[shop_id] = floor


if __name__ == '__main__':
    main()
