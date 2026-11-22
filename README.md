![image](https://user-images.githubusercontent.com/106916061/179006347-497d24c0-9bd6-45b7-8c49-d5cc8ecfe5d7.png)
# BambuStudio
Bambu Studio is a cutting-edge, feature-rich slicing software.  
It contains project-based workflows, systematically optimized slicing algorithms, and an easy-to-use graphic interface, bringing users an incredibly smooth printing experience.

Prebuilt Windows, macOS 64-bit and Linux releases are available through the [github releases page](https://github.com/bambulab/BambuStudio/releases/).

Bambu Studio is based on [PrusaSlicer](https://github.com/prusa3d/PrusaSlicer) by Prusa Research, which is from [Slic3r](https://github.com/Slic3r/Slic3r) by Alessandro Ranellucci and the RepRap community.

See the [wiki](https://github.com/bambulab/BambuStudio/wiki) and the [documentation directory](https://github.com/bambulab/BambuStudio/tree/master/doc) for more information.

# What are Bambu Studio's main features?
Key features are:
- Basic slicing features & GCode viewer
- Multiple plates management
- Remote control & monitoring
- Auto-arrange objects
- Auto-orient objects
- Hybrid/Tree/Normal support types, Customized support
- multi-material printing and rich painting tools
- multi-platform (Win/Mac/Linux) support
- Global/Object/Part level slicing parameters

Other major features are:
- Advanced cooling logic controlling fan speed and dynamic print speed
- Auto brim according to mechanical analysis
- Support arc path(G2/G3)
- Support STEP format
- Assembly & explosion view
- Flushing transition-filament into infill/object during filament change

# VFlow printing speed

VFlow adds volumetric-flow-based speed input to selected print-speed settings. The existing speed fields accept either an absolute speed or a percentage of the selected filament's maximum volumetric flow:

- A plain number such as `50` means an absolute print speed of `50 mm/s`.
- A percentage such as `36%` means a target flow equal to 36% of the selected filament's `Max volumetric speed`.
- `100%` targets the filament's full configured maximum volumetric flow.

The `Max volumetric speed` value remains in the filament settings. It is the common upper flow limit for both input modes; there is no separate `Target VFlow` filament setting. The existing speed settings remain in the Speed category/tab and are available in Advanced mode.

For percentage input, the target volumetric flow is converted to linear speed using the actual extrusion cross-section of each toolpath. The calculation uses the generated line width and layer height, including the rounded sides of the extruded line; nozzle diameter is not used as a substitute for line width. Consequently, the resulting `mm/s` speed can vary between paths even when the same percentage is configured.

For example, with a filament maximum of `10 mm³/s`, `50%` targets `5 mm³/s`. A `0.4 mm` line printed at `0.2 mm` layer height has an approximate rounded-rectangle cross-section of `0.0714 mm²`, which corresponds to about `70 mm/s` at that target flow. The actual value is calculated from each sliced path.

Absolute `mm/s` values continue to work as before. If an absolute speed would exceed the configured filament flow limit for a toolpath, the speed is reduced to respect that limit. The same filament maximum also caps percentage-based requests. Percentages above `100%` therefore do not currently override the filament maximum; an optional over-100% override is a separate future enhancement and is not part of the current behavior.

VFlow percentage input is currently supported by these speed settings:
- Inner wall
- Outer wall
- Sparse infill
- Internal solid infill
- Top surface

Other speed settings remain absolute unless their setting explicitly accepts a percentage for another purpose. The VFlow conversion is used by G-code speed generation and the relevant print-time estimation path.

# How to compile
Following platforms are currently supported to compile:
- Windows 64-bit, [Compile Guide](https://github.com/bambulab/BambuStudio/wiki/Windows-Compile-Guide)
- Mac 64-bit, [Compile Guide](https://github.com/bambulab/BambuStudio/wiki/Mac-Compile-Guide)
- Linux, [Compile Guide](https://github.com/bambulab/BambuStudio/wiki/Linux-Compile-Guide)
  - currently we only provide linux appimages on [github releases](https://github.com/bambulab/BambuStudio/releases) for Ubuntu/Fedora, and a [flathub version](https://flathub.org/apps/com.bambulab.BambuStudio) can be used for all the linux platforms

# Report issue
You can add an issue to the [github tracker](https://github.com/bambulab/BambuStudio/issues) if **it isn't already present.**

# License
Bambu Studio is licensed under the GNU Affero General Public License, version 3. Bambu Studio is based on PrusaSlicer by PrusaResearch.

PrusaSlicer is licensed under the GNU Affero General Public License, version 3. PrusaSlicer is owned by Prusa Research. PrusaSlicer is originally based on Slic3r by Alessandro Ranellucci.

Slic3r is licensed under the GNU Affero General Public License, version 3. Slic3r was created by Alessandro Ranellucci with the help of many other contributors.

The GNU Affero General Public License, version 3 ensures that if you use any part of this software in any way (even behind a web server), your software must be released under the same license.

The bambu networking plugin is based on non-free libraries. It is optional to the Bambu Studio and provides extended networking functionalities for users.
By default, after installing Bambu Studio without the networking plugin, you can initiate printing through the SD card after slicing is completed.

