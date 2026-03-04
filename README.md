# repo structure
```
.
├── flake.nix        # Core inputs & channel definitions
├── hosts            # Host specific configurations
│   ├── mediaserver   # Mediaserver
│   ├── nova          # Storage
│   ├── r7game-wsl    # WSL instance on gaming machine
│   └── t480s         # Thinkpad
├── modules          # Reusables
│   ├── common        # General common things
│   └── home          # Home manager profiles
└── vars
    └── secrets.nix  # Variables not meant for the public eye
```

# todo
- separate the desktop part from pierre's home manager
- restructure secrets.nix into
  - `<host>`
    - ssh
      - public_key
      - private_key
    - wg
      - public_key
      - private_key
      - vpn_ip
    - ?ip
    - ?home_ip
    - ?password hash
  - more?
- move actual secrets into a sops setup with quantum encryption
- put nixos on eth
- remove `hmrb`
- refine zsh config
- refine portable zsh config
- create alias to easily deploy to servers
- spread wsl and laptop ssh pub keys to all servers
- seperate portable zsh autoload from ssh into seperate command
    

# issue tracker
- https://gitlab.gnome.org/GNOME/mutter/-/issues/4494
