----------------------------------------------------
## Ubuntu 15.04 compatibility (Vivid Vervet) checks:
----------------------------------------------------

**Requires multi-arch?**: yes  
**All Packages Tested?**: no

### TODO
- Build in traps to separate upstart from systemd for 15.04
- Create system startup service files
- check all paths against 15.04
- recheck Vivid packages against project

### Emulators
* pcsx2: [needs tested]
* dolphin-emu-master: 
* libretro (stable): Multi, see below
      * libretro-beetle-vb [needs tested]
      * libretro-beetle-wsan [needs tested]
      * libretro-desmume [needs tested]
* libretro (testing): Multi, see below
      * libretro-scummvm [needs tested]
      * libretro-4do [needs tested]
* gens [needs tested]
* mupen64plus [needs tested]
* mame [needs tested]
* mess [needs tested]
* mednafen [needs tested]
* ppsspp [needs tested]
* stella [needs tested]

### Tools / other
* antimicro [needs tested]
* getpos [needs tested]
* joydetect [needs tested]
* libsdl2-i386 [needs tested]
* polarssl [needs tested]
* qtsixa [needs tested]
* shairplay, N/A (remnant of XBMX RetroRig?)
* retrorig-setup, **NO**, needs built / imported
