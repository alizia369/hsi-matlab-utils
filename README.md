# Hyperspectral MATLAB Utilities

**Ali Zia**
*Supporting code for the PhD thesis “Exploring Extrinsic Spectral Properties of Hyperspectral Image for 3D Computer Vision”, Griffith University, 2020*

[![Thesis](https://img.shields.io/badge/Thesis-Griffith%202020-blue)](https://research-repository.griffith.edu.au/items/6c4ccabf-f952-4780-8592-ac6f8ea62dae) ![Language](https://img.shields.io/badge/Language-MATLAB-orange) [![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

> **Status.** This is the original research code behind the publication,
> prepared for release. Duplicate, backup and autosave files, data and personal
> file paths were removed and third-party code was separated into
> `third_party/`; the algorithms themselves were not modified. It is research
> code rather than a polished toolbox, and it was developed on Windows MATLAB.

## Overview

These are the small, general-purpose MATLAB functions for reading,
correcting, normalising and viewing hyperspectral cubes. They were written
during the PhD project above and form the shared data-handling layer behind
its chapters and the related papers. Each of the companion repositories
includes copies of the functions it needs, so this collection is only required
if you want the helpers on their own.

## Method

The functions follow the usual pre-processing chain for laboratory and field
hyperspectral data:

1. **Reading.** ENVI cubes and headers (`Load_Spec.m`,
   `third_party/read_envihdr`), and raw snapshot-mosaic frames, which are
   demosaicked into cubes with per-camera correction matrices (`X2Cube*.m` with
   `cormat_*.mat`).
2. **Radiometric correction.** Dark-frame subtraction (`darknormalise.m`),
   percentile normalisation and noise suppression (`normalise*.m`,
   `removenoise.m`).
3. **Saving and inspection.** Camera-specific savers (`saveCube*.m`), per-band
   image export (`SaveImage2EachBand.m`), cube display (`Displaycube.m`),
   patch extraction (`im2patches.m`) and a Gaussian pyramid
   (`GaussianPyramid.m`).
4. **Visualisation.** Rendering a reflectance cube as an sRGB image via CIE XYZ
   (`examples_spectral_to_rgb/`), and a GUIDE tool for cropping a region of a
   cube (`gui/crop_hypercube/`).

## Repository structure

```
setup_paths.m                 add all code folders to the MATLAB path
io/                           reading, correction, normalisation and saving of cubes
gui/crop_hypercube/           GUIDE tool to crop a cube
examples_spectral_to_rgb/     reflectance -> radiance -> CIE XYZ -> sRGB rendering
third_party/                  ENVI header reader, im2colstep MEX
```

## Requirements

- MATLAB with the Image Processing Toolbox
- Some savers assume Windows-style paths

## Getting started

```matlab
>> cd hsi-matlab-utils
>> setup_paths
>> [cube, wavelengths] = Load_Spec('.\data\scene.dat');
>> cube = normalise(cube, 'percent', 0.999);
>> mat = cube; Displaycube     % script: browse bands of the variable `mat`
```

## Data

No data are included. The `examples_spectral_to_rgb/` scripts expect a
reflectance cube in the format of D. H. Foster's public hyperspectral image
sets. The illuminant and colour-matching `.mat` files they need are included.

## Notes on reproducibility

- `X2CubeFor16BandVIS.m` and `X2CubeFor25Band.m` are tied to specific
  snapshot-mosaic sensors (4×4 visible and 5×5 near-infrared). Their correction
  matrices are included as `cormat_*.mat`. The 4×4 version calls the
  `im2colstep` MEX, for which a Windows 64-bit binary is included; compile
  `third_party/im2colstep/im2colstep.c` on other platforms.
- `normalise_bk.m` and `normalise_smooth.m` are earlier variants of
  `normalise.m`, kept for compatibility with older scripts.

## Citation

If you use this code, please cite:

```bibtex
@phdthesis{zia2020thesis,
  title  = {Exploring Extrinsic Spectral Properties of Hyperspectral Image for 3D Computer Vision},
  author = {Zia, Ali},
  school = {Griffith University},
  year   = {2020},
  url    = {https://research-repository.griffith.edu.au/items/6c4ccabf-f952-4780-8592-ac6f8ea62dae}
}
```

A `CITATION.cff` file is included, so GitHub's **Cite this repository** button gives the same reference.

## Licence and third-party code

The author's code is released under the **MIT licence** (see `LICENSE`).
`io/Load_Spec.m` was written by Jie Liang. The ENVI header reader (Jarek
Tuszynski), the `im2colstep` MEX (Ron Rubinstein) and the colour-rendering
scripts, which follow D. H. Foster's public tutorial, keep their own terms;
see `third_party/README.md`.

## Acknowledgements

Developed at the School of Information and Communication Technology, Griffith University, Australia.

## Contact

Questions and bug reports are welcome through [GitHub issues](https://github.com/alizia369/hsi-matlab-utils/issues).
Ali Zia, La Trobe University — [www.ali-zia.me](https://www.ali-zia.me)

## Related repositories

This repository is one of a set released together from the same line of work on hyperspectral computer vision:

- [`hsi-3d-reconstruction`](https://github.com/alizia369/hsi-3d-reconstruction): 3D reconstruction from hyperspectral images (WACV 2015)
- [`hsi-relative-depth-estimation`](https://github.com/alizia369/hsi-relative-depth-estimation): Relative depth from a hyperspectral cube (DICTA 2015)
- [`hsi-chromatic-defocus-depth`](https://github.com/alizia369/hsi-chromatic-defocus-depth): Chromatic aberration + defocus for relative depth (IEEE TIP 2021)
- [`hsi-occluded-object-detection`](https://github.com/alizia369/hsi-occluded-object-detection): Occluded object detection (PhD thesis, arXiv forthcoming)
- [`hsi-material-boundary-detection`](https://github.com/alizia369/hsi-material-boundary-detection): Material-based boundary detection (DICTA 2017)
- [`sugarcane-smut-hsi`](https://github.com/alizia369/sugarcane-smut-hsi): Early sugarcane smut detection (IVCNZ 2021)
