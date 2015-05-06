#!/usr/bin/python

""" Partition a list into sublists whose sums don't exceed a maximum 
    using a First Fit Decreasing algorithm. See
    http://www.ams.org/new-in-math/cover/bins1.html
    for a simple description of the method.
"""


class Bin(object):
    """ Container for items that keeps a running sum """
    def __init__(self):
        self.items = []
        self.sum = 0

    def append(self, item):
        self.items.append(item)
        self.sum += item

    def __str__(self):
        """ Printable representation """
        return 'Bin(sum=%d, items=%s)' % (self.sum, str(self.items))


def pack(values, maxValue):
    values = sorted(values, reverse=True)
    bins = []

    for item in values:
        # Try to fit item into a bin
        for bin in bins:
            if bin.sum + item <= maxValue:
                #print 'Adding', item, 'to', bin
                bin.append(item)
                break
        else:
            # item didn't fit into any bin, start a new bin
            #print 'Making new bin for', item
            bin = Bin()
            bin.append(item)
            bins.append(bin)

    return bins


if __name__ == '__main__':
    import random

    weights = {
        'mi-gp0.treasure-data.com': 32423,
        'mi-gree-58594.treasure-data.com': 3649,
        'mi-gree-943.treasure-data.com': 3580,
        'mi-gree-3438.treasure-data.com': 3546,
        'mi-gree-58703.treasure-data.com': 3372,
        'mi-gree.treasure-data.com': 2820,
        'mi-gree-53190.treasure-data.com': 2504,
        'mi-gree-58243.treasure-data.com': 1947,
        'mi-gree-59572.treasure-data.com': 1839,
        'mi-gree-95.treasure-data.com': 1667,
        'mi-gree-57737.treasure-data.com': 1628,
        'mi-gree-2676.treasure-data.com': 1465,
        'mi-gree-1242.treasure-data.com': 1402,
        'mi-gree-53188.treasure-data.com': 1114,
        'mi-gree-58195.treasure-data.com': 1004,
        'mi-gree-112.treasure-data.com': 1003,
        'mi-gree-98.treasure-data.com': 883,
        'mi-gree-99.treasure-data.com': 839,
        'mi-gree-97.treasure-data.com': 615,
        'mi-gree-2522.treasure-data.com': 535,
        'mi-gree-54783.treasure-data.com': 458,
        'mi-gree-53202.treasure-data.com': 444,
        'mi-gree-96.treasure-data.com': 245,
        'mi-gree-59789.treasure-data.com': 183
    }
    weight_rev = {}
    for x in weights.keys():
        weight_rev[weights[x]]=x

    def packAndShow(aList, maxValue):
        """ Pack a list into bins and show the result """
        print 'List with sum', sum(aList), 'requires at least', (sum(aList)+maxValue-1)/maxValue, 'bins'

        bins = pack(aList, maxValue)

        print 'Solution using', len(bins), 'bins:'
        for bin in bins:
            print bin

        print

    

    aList = weights.values()
    tot=0
    for x in weights:
        tot+=weights[x]

    n = tot/3

    #aList = [10,9,8,7,6,5,4,3,2,1]
    packAndShow(aList, n)

    #aList = [ random.randint(1, 11) for i in range(100) ]
    #packAndShow(aList, 11)
