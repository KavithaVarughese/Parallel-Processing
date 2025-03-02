import matplotlib.pyplot as plt
import matplotlib.ticker as plticker
import pandas as pd

df = pd.read_csv("results.csv")
perfomance = {"P":[], "Speedup": [], "Efficiency %": []}

i = 0
for j in df.columns.values[1:]:
    perfomance["P"].append(j)
    # WEAK SCALING
    speedup = (df.iloc[0]['1'] + int(j) * df.iloc[i][j]) / (df.iloc[0]['1'] + df.iloc[i][j]) 

    #STRONG SCALING
    # speedup = (df.iloc[4]['1']) / (df.iloc[4][j]) 
    
    perfomance["Speedup"].append(speedup)
    perfomance["Efficiency %"].append(
        speedup * 100 / int(j)
    )

    i = i + 1

perfomance_df = pd.DataFrame(perfomance)
perfomance_df.to_csv("performance.csv", index=False)

# PLOT GRAPH
fig, ax = plt.subplots()
plt.title("Strong Scaling for n from 5000 to 640000")
plt.xlabel("Number of processors")
plt.ylabel("Speedup (S)")

P = [int(x) for x in df.columns.values[1:]]
ax.plot(P, P, 'r-', label='Trendline', color='r')
ax.plot(P, perfomance["Speedup"], marker='o', linestyle='-', color='b', label="Speedup (S)")

ax.set_xticks(P)

ax.legend()
ax.grid(True)
plt.show()