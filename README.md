# black (Software for spectroradiometric temperature measurement

[![DOI](https://zenodo.org/badge/81541147.svg)](https://zenodo.org/badge/latestdoi/81541147)

Black is a GUI written using the Matlab© GUIDE© package and is designed to process .SPE files collected from an Princeton Instruments Acton spectrograph for the determination of temperature during double sided laser heating experiments in the diamond anvil cell. The software is designed around the laser heating system in the School of Earth Sciences, University of Bristol.

The software can operate in both a live mode (during an experiment) where it will automatically process new files as they arrive or a post-processing mode, where files within a folder can be processed rapidly and sequentially. The software can process data from both sides of the sample simultaneously, assuming the incandescent light from each side is spatially separated but focussed onto the same CCD chip by the spectrometer.

The software provides the user with plots of temperature cross-sections as well as the peak temperature from both sides as a function of elapsed time. Several optional subroutines are available, including boxcar smoothing, temperature correction based on chromatic aberration, error minimisation based on wavelength window optimisation and an auto-rotation feature that can correct for the incident light being non-orthogonal to the spectrometer slit.

Future improvements include: making the software as hardware independent as possible, improving the commenting and efficiency of the code and writing a complete README file with operational instructions and instructions on how to edit the code for different hardware configurations. Currently, if you want to use the software and would like help on how to adapt it for a specific hardware setup, then contact me at <oliver.lord@bristol.ac.uk>.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

MIRRORS requires Matlab and its image and statistics toolboxes to run and was written and tested on versions R2014a (Windows 7) & R2015/17a (OS X 10.13). It will likely work on all versions after R2014a on both Windows and OS X, but has not been tested. 

You will also need:

1. A spectroradiometric temperature measurement system that produces 8-bit .SPE files (generated by Princeton Instruments Winspec software) with a resolution of 1024 x 256 pixels. The software assumes that the incandescent light from the sample is dispersed in wavelength across the long axis of the CCD and that the short axis is a spatial dimension such that light from the left hand side of the system is focused between lines 128:256 while light from the right is focused between lines 1:127.   The pixel:wavelength relationship of the spectrometer must be known (usually based on a calibration performed using a Hg lamp or similar). The files should have monotonic (though not necessarily sequential) numbers appended to them immediatley before the extension.

2. Two thermal calibration .SPE files produced using a calibrated source of known spectral radiance.

Details of the hardware set up at the School of Earth Sciences, University of Bristol for which this software was developed can be found in Lord et al. (2014a,b). The mathematical underpinnings of the code can be found in Walter & Koga (2004).

### Installing

Simply navigate to https://github.com/olivertlord/black/releases/latest and download the latest source code (as either a .ZIP or .tar.gz file) and extract to your desired location. 

To run black, simply open Matlab, navigate to the black directory and then type

```
black
```

To add the black directory to the Matlab PATH, at the Matlab command prompt type:

```
location = userpath
location = location(1:end-1)
cd(location)
edit startup.m
```

At this point, if you are prompted to create ```startup.m```, then do so. In the new .m file that opens in the Editor, add the following line and resave:

```
addpath(genpath('~/black'));
```

Where ```~/black``` is the full path to your MIRRORS directory. Now, next time you start Matlab, black will be on the Matlab PATH and you can type black at the command prompt from any directory and the GUI should run.

### Testing

A dataset for benchmarking as well as detailed instructions on how to test your installation of black will be made available in a future release

### Hardware specific code edits

Details on how to edit the code to make it compatible with a specific hardware set up will be made available in a future release.

### Troubleshooting

If you detect any bugs during use, then please contact me (Oliver Lord) at <oliver.lord@bristol.ac.uk>. Suggestions for new features are also welcome.

## Authors

* **Oliver Lord, School of Earth Science, Univeristy of Bristol** - (https://github.com/olivertlord, https://seis.bristol.ac.uk/~glotl/index.html)

* **Michael Walter, Geophysical Laboratory, Carnegie Institution of Washington** - Initial Development (http://www.innotecuk.com/)

## License

This project is licensed under the GNU General Public Licence Version 3 - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* The students and post-doctoral researchers at the DAC lab, School of Earth Sciences, University of Bristol, who tested the software, detected numerous bugs and suggested improvements.
* I (Oliver Lord) would like to acknowledge support from the Royal Society in the form of a University Research Fellowship (UF150057) and the Natural Environment Research Council (NERC) in the form of an Post-doctoral Research Fellowship (NE/J018945/1).

## References

* Lord, O. T., Wood, I. G., Dobson, D. P., Vočadlo, L., Wang, W., Thomson, A. R., et al. (2014a). The melting curve of Ni to 1 Mbar. Earth and Planetary Science Letters, 408, 226–236. http://doi.org/moving 10.1016/j.epsl.2014.09.046

* Lord, O. T., Wann, E. T. H., Hunt, S. A., Walker, A. M., Santangeli, J., Walter, M. J., et al. (2014b). The NiSi melting curve to 70GPa. Physics of the Earth and Planetary Interiors, 233, 13–23. http://doi.org/10.1016/j.pepi.2014.05.005

* Walter, M. J., & Koga, K. T. (2004). The effects of chromatic dispersion on temperature measurement in the laser-heated diamond anvil cell. Physics of the Earth and Planetary Interiors, 143-144, 541–558. http://doi.org/10.1016/j.pepi.2003.09.019

