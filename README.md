# useful-vps-scripts

Scripts that I use on my VPSes.

## Installation

Run the following:

```bash
SCRIPTS_DIR=$(mktemp); git clone https://github.com/SivkovSavely/useful-vps-scripts.git $SCRIPTS_DIR; rm $SCRIPTS_DIR/LICENSE $SCRIPTS_DIR/README.md; cp -r $SCRIPTS_DIR/* ~e; rm -rf $SCRIPTS_DIR
```

Or, with newlines:

```bash
SCRIPTS_DIR=$(mktemp)
git clone https://github.com/SivkovSavely/useful-vps-scripts.git $SCRIPTS_DIR
rm $SCRIPTS_DIR/LICENSE $SCRIPTS_DIR/README.md
cp -r $SCRIPTS_DIR/* ~e
rm -rf $SCRIPTS_DIR
```