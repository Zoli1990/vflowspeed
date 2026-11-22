![image](https://user-images.githubusercontent.com/106916061/179006347-497d24c0-9bd6-45b7-8c49-d5cc8ecfe5d7.png)
# VFlow – Bambu Studio modification

This repository is an unofficial Bambu Studio modification based on Bambu Studio 2.9.1.70. It adds volumetric-flow-based percentage input to selected print-speed settings while retaining the original absolute mm/s input.
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

VFlow adds volumetric-flow-based speed input to five existing print-speed settings. The user can continue entering an absolute speed in mm/s or enter a percentage of the selected filament's `Max volumetric speed` directly in the same field.

## How to enter a speed

- `50` means an absolute print speed of `50 mm/s`.
- `50%` means a target flow equal to 50% of the selected filament's `Max volumetric speed`.
- `100%` targets the filament's full configured maximum volumetric flow.

The percentage is converted to a linear print speed (`mm/s`) using the actual extrusion cross-section of each toolpath, including its line width and layer height. The same percentage can therefore produce different linear speeds for paths with different cross-sections.

For example, with a filament `Max volumetric speed` of `10 mm³/s`, a `50%` setting targets `5 mm³/s`. The slicer calculates the corresponding `mm/s` speed from each path's actual cross-section.

## Filament Max volumetric speed

The filament's `Max volumetric speed` now has two related roles:

1. It is the reference value for percentage-based print speeds. For example, `50%` targets half of this value.
2. It remains the upper volumetric-flow limit for both percentage-based and absolute `mm/s` speed settings.

There is no separate `Target VFlow` filament setting. To speed up or slow down a percentage-based print profile for a different filament, adjust the filament's `Max volumetric speed` value instead of recalculating every feature speed.

## Supported speed settings

VFlow percentage input is currently supported by these existing settings in the Speed category/tab:

- Inner wall
- Outer wall
- Sparse infill
- Internal solid infill
- Top surface

Other speed settings remain unchanged and continue to use their existing input behavior.

## Interaction with cooling and other speed limits

VFlow determines the nominal speed needed to reach the requested volumetric flow. It does not override other slicer limits. Maximum print speed, acceleration, overhang rules, minimum layer-time cooling slowdowns and other existing constraints can reduce the final speed written to G-code. The filament's maximum volumetric speed also remains a hard upper flow limit; percentages above `100%` do not currently bypass it.

The generated G-code should be used to verify the final speed and flow on a specific model, because cooling and geometry-dependent constraints can change the actual motion speed.

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

