# AutoArch

Reproducible Arch Linux automatic installation script

## Usage
### 1. Download the scripts

If the machine has access to the internet (as is required for the install to succeed), I recommend cloning the whole repository.

```sh
  git clone https://github.com/PedroMezquita/AutoArch.git
```

### 2. Check the configuration

As the scripts will install Arch Linux following the configuration file ```configuration.conf```, I advise modifying the file to adapt it to your needs.

### 3. Launch

Once the configuration file is ready, launch the script

```sh
  ./autoarch.sh
```

You will be asked for a password for the admin user during the installation.

## To Do

This project is still in an early stage, so there are some rough edges that need some improvement

- Script that creates the configuration file
- Compatibility with non-UEFI systems
- Flexibility on user creation
