import matplotlib.pyplot as plt
import matplotlib.ticker as plticker
import pandas as pd

df = pd.read_csv("results.csv")
perfomance = {"P":[], "Speedup": [], "Efficiency %": []}

"""
strong = T1/TP

week = TS + pTp / Ts+Tp
"""

p = df.iloc[:, 0].to_list()
print(p)

i = 0
for rank in p:
    perfomance["P"].append(rank)

    # WEAK SCALING
    speedup = (df.iloc[0,1] + int(rank) * df.iloc[i,i+1]) / (df.iloc[0,1] +  df.iloc[i,i+1]) 

    # strong scaling
    # speedup = (df.iloc[0, -1] / df.iloc[i, -1])
    
    perfomance["Speedup"].append(speedup)
    perfomance["Efficiency %"].append(
        speedup * 100 / int(rank)
    )

    i = i + 1

perfomance_df = pd.DataFrame(perfomance)
perfomance_df.to_csv("performance.csv", index=False)

# PLOT GRAPH
fig, ax = plt.subplots()
plt.title("Strong Scaling for N = 1.024 x 10^6")
plt.xlabel("Number of processors")
plt.ylabel("Speedup (S)")

P = [int(x) for x in p]
ax.plot(P, P, 'r-', label='Trendline', color='r')
ax.plot(P, perfomance["Speedup"], marker='o', linestyle='-', color='b', label="Speedup (S)")

loc = plticker.MultipleLocator(base=2)
ax.xaxis.set_major_locator(loc)
ax.yaxis.set_major_locator(loc)

ax.legend()
ax.grid(True)
plt.show()