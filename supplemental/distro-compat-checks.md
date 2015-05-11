----------------------------------------------------
## Ubuntu 15.04 compatibility (Vivid Vervet) checks:
----------------------------------------------------

**Needs redone fro 15.04 (previously 14.10)**  
**Requires multi-arch?**: yes  
**All Packages Tested?**: no

### Emulators
* pcsx2: OK, 32-bit
* dolphin-emu-master: OK, 64-bit
* libretro (stable): Multi, see below
      * libretro-beetle-vb, OK, 32/64-bit
      * libretro-beetle-wsan, OK, 32/64-bit
      * libretro-desmume, OK, 32/64-bit
* libretro (testing): Multi, see below
      * libretro-scummvm, OK, 32/64-bit
      * libretro-4do, OK, 32/64-bit
* gens, OK, built, **needs tested**
* mupen64plus, OK, 32-bit (core pkg),32/64-bit (all else), imported
* mame, OK, imported, 32/64-bit
* mess, **Needs tested**, needs built / imported
* mednafen, OK, 32/64-bit
* ppsspp, OK, 32/64-bit
* stella, OK, 32/64-bit

### Tools / other
* antimicro, OK, 32/64-bit
* getpos, OK, 32/64-bit
* joydetect, OK, 32/64-bit
* libsdl2-i386, **NO**, needs built / imported
* polarssl, OK, part of official repository
* qtsixa, OK, 32/64-bit
* shairplay, N/A (remnant of XBMX RetroRig?)
* retrorig-setup, **NO**, needs built / imported

----------------------------------------------------
## Ubuntu 15.04 compatibility (Vivid) checks:
----------------------------------------------------

* TODO
