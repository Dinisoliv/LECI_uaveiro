ATP1 = float(input("ATP1? "))
ATP2 = float(input("ATP2? "))
AP = float(input("AP? "))
APF = float(input("APF? "))
CTP = ((0.15 * ATP1 + 0.15 * ATP2)/0.3)
CP = ((0.2 * AP + 0.5 * APF)/0.7)
NF = int((((0.15 * ATP1) + (0.15 * ATP2))/0.3) + (((0.2 * AP) + (0.5 * APF))/0.7)) 
if (CP < 6.5 or CTP < 6.5) :
 NF = 66
print("Nota final =", NF)
if (NF > 10 and NF != 66):
 print("aprovado em época normal")
else:
 print("reprovado em época normal")
 print("Vai a recurso")
if (NF < 10 or NF == 66):
 ATPR = float(input("ATPR? "))
 APR = float(input("APR? "))
 NR = 0.3 * ATPR + 0.7 * APR
 print("Nota de recurso =", NR)
if (NR >10):
 print("aprovado em recurso")
else:
 print("reprovado em recurso")
 