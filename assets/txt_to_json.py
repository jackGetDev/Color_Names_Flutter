import json

with open("colors.txt", "r") as file:
    data = file.read().splitlines()

result = list(zip(data[0::2], data[1::2]))

# Membuat objek dictionary untuk hasil
output = []
for item in result:
    output.append({"name": item[0], "color": item[1]})

# Menulis hasil dalam format JSON ke file baru
with open("color_names.json", "w") as file:
    json.dump(output, file)
