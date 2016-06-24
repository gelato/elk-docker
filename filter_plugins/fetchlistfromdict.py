def fetchlistfromdict(d, l):
    result = []
    for item in l:
        result.append(d[item])
    return result

class FilterModule(object):
    def filters(self):
        return {
            'fetchlistfromdict': fetchlistfromdict,
        }
