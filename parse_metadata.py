header = '  - key: ssh-keys\n'
offset = 6
spacing = ' ' * offset


def write(output, keys):
    f = open(output, 'a')
    for key in keys:
        f.write(key)
    f.close()


def getkeys(inpt):
    keys = []
    f = open(inpt)
    for line in f:
        # print(line)
        if line == header:
            # value header
            f.readline()

            # first? value
            val = f.readline()
            while (val[:offset] == spacing):
                keys.append(val[offset:])
                val = f.readline()

            # key section over
            break
    return keys
    f.close()


if __name__ == '__main__':
    import sys
    keys = getkeys(sys.argv[1])
    write(sys.argv[2], keys)
