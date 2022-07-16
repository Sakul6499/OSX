latest: macOS-Monterey

all: macOS-High-Sierra macOS-Mojave macOS-Catalina macOS-Big-Sur macOS-Monterey

# Cleans
clean: clean-dmg clean-vdi clean-vmdk clean-img

clean-dmg:
	rm *.dmg

clean-vdi:
	rm *.vdi

clean-vmdk:
	rm *.vmdk

clean-img:
	rm *.img

# Targets
macOS-High-Sierra: macOS-High-Sierra.vmdk macOS-High-Sierra.vdi macOS-High-Sierra.img
macOS-Mojave: macOS-Mojave.vmdk macOS-Mojave.vdi macOS-Mojave.img
macOS-Catalina: macOS-Catalina.vmdk macOS-Catalina.vdi macOS-Catalina.img
macOS-Big-Sur: macOS-Big-Sur.vmdk macOS-Big-Sur.vdi Big-Sur.img
macOS-Monterey: macOS-Monterey.vmdk macOS-Monterey.vdi macOS-Monterey.img

# File-Format targets
all-dmg: macOS-High-Sierra.dmg macOS-Mojave.dmg macOS-Catalina.dmg macOS-Big-Sur.dmg macOS-Monterey.dmg
all-img: macOS-High-Sierra.img macOS-Mojave.img macOS-Catalina.img macOS-Big-Sur.img macOS-Monterey.img
all-vdi: macOS-High-Sierra.vdi macOS-Mojave.vdi macOS-Catalina.vdi macOS-Big-Sur.vdi macOS-Monterey.vdi
all-vmdk: macOS-High-Sierra.vmdk macOS-Mojave.vmdk macOS-Catalina.vmdk macOS-Big-Sur.vmdk macOS-Monterey.vmdk

# Download DMG's
macOS-High-Sierra.dmg:
	echo "Downloading 'macOS-High-Sierra.dmg' ..."
	echo "1" | ./fetch-macOS-v2.py
	mv BaseSystem.dmg macOS-High-Sierra.dmg

macOS-Mojave.dmg:
	echo "Downloading 'macOS-Mojave.dmg' ..."
	echo "2" | ./fetch-macOS-v2.py
	mv BaseSystem.dmg macOS-Mojave.dmg

macOS-Catalina.dmg:
	echo "Downloading 'macOS-Catalina.dmg' ..."
	echo "3" | ./fetch-macOS-v2.py
	mv BaseSystem.dmg macOS-Catalina.dmg

macOS-Big-Sur.dmg:
	echo "Downloading 'macOS-Big-Sur.dmg' ..."
	echo "4" | ./fetch-macOS-v2.py
	mv BaseSystem.dmg macOS-Big-Sur.dmg

macOS-Monterey.dmg:
	echo "Downloading 'macOS-Monterey.dmg' ..."
	echo "5" | ./fetch-macOS-v2.py
	mv BaseSystem.dmg macOS-Monterey.dmg

# Converters
%.img: %.dmg
	echo "Converting $< into $@ ..."
	dmg2img $< $@

%.vmdk: %.img
	echo "Converting $< into $@ ..."
	qemu-img convert -O vmdk $< $@

%.vdi: %.img
	echo "Converting $< into $@ ..."
	qemu-img convert -O vdi $< $@
