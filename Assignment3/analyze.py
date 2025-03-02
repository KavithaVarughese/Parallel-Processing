import matplotlib.pyplot as plt
import pandas as pd

# PLOT GRAPH
fig, ax = plt.subplots()
plt.title("GPU vs CPU")
plt.xlabel("Data Size")
plt.ylabel("Speedup (CPU/GPU)")

# READ DATA
df = pd.read_csv("results.csv")

cpu = df['CPU Runtime (s)'].values
gpu = df['GPU Runtime (s)'].values
n = df['n'].values

speedup = []
for i in range(len(cpu)):
    speedup.append(cpu[i]/gpu[i])

ax.plot(n, speedup, marker='o', linestyle='-', color='b', label="Speedup (S)")

# ax.set_xticks(n)

ax.legend()
ax.grid(True)
plt.show()