# Arch packages backup
Inspired by [this](https://github.com/bruhtus/package-backup) repository.

Everything related to Arch is in the `arch` directory.
```bash
cd arch
```

Save installed packages
```bash
./bck_pkgs.sh <profile>
```

Restore from backup
```bash
sudo pacman -S --needed - <profile>_pkglist-repo.txt
for x in $(<profile>_pkglist-aur.txt); do yay -S $x; done
```

`<profile>` is the name of the backup profile. It can be string like `home`, `work`, etc.

