def seqsearch (lst,x):
for k in range(len(lst)):
    if x == lst[k]:
        return k
return None
