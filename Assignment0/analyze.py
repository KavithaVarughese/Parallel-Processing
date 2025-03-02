import matplotlib.pyplot as plt
import matplotlib.ticker as plticker
import pandas as pd

df = pd.read_csv("results.csv")
perfomance = {"P":[], "Speedup": [], "Efficiency %": []}

i = 0
for j in df.columns.values[1:]:
    perfomance["P"].append(j)
    # WEAK SCALING
    # speedup = (df.iloc[0]['1'] + int(j) * df.iloc[i][j]) / (df.iloc[0]['1'] + df.iloc[i][j]) 

    #STRONG SCALING
    speedup = (df.iloc[5]['1']) / (df.iloc[5][j]) 
    
    perfomance["Speedup"].append(speedup)
    perfomance["Efficiency %"].append(
        speedup * 100 / int(j)
    )

    i = i + 1

perfomance_df = pd.DataFrame(perfomance)
perfomance_df.to_csv("performance.csv", index=False)

# PLOT GRAPH
fig, ax = plt.subplots()
plt.title("Strong Scaling for N = 1.024 x 10^6")
plt.xlabel("Number of processors")
plt.ylabel("Speedup (S)")

P = [int(x) for x in df.columns.values[1:]]
ax.plot(P, P, 'r-', label='Trendline', color='r')
ax.plot(P, perfomance["Speedup"], marker='o', linestyle='-', color='b', label="Speedup (S)")

loc = plticker.MultipleLocator(base=2)
ax.xaxis.set_major_locator(loc)
ax.yaxis.set_major_locator(loc)

ax.legend()
ax.grid(True)
plt.show()