# Linux Configs
My Linux configuration files and scripts.

## Dotfiles
1. Install [Stow](https://www.gnu.org/software/stow/)
2. Apply dotfiles
```bash
make user
```

## Arch packages
This part is inspired by [this](https://github.com/bruhtus/package-backup) repository.

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

