# Package lists

## Distros
### Arch
Inspired by [this](https://github.com/bruhtus/package-backup) repository.

Save installed packages
```bash
arch_bck.sh <profile>
```

Restore from backup
```bash
sudo pacman -S --needed - < <profile>_pkglist-repo.txt
for x in $(<profile>_pkglist-aur.txt); do yay -S $x; done
```

`<profile>` is the name of the backup profile. It can be string like `home`, `work`, etc.

### Debian
Packages are manually updated for now.

Install from package list file:
```bash
sudo apt update
sudo apt install -y $(cat pkglist.txt)
```

## Other packages 
This repository works with or without these, but I use these packages myself, so I included some configurations for them.
1. [ble.sh](https://github.com/akinomyoga/ble.sh)
2. [Starship](https://starship.rs/guide/)

