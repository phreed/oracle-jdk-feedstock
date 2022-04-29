About oracle-jdk
================

Home: https://github.com/phreed/oracle-jdk-feedstock

Package license: MIT

Feedstock license: [BSD-3-Clause](https://github.com/phreed/oracle-jdk-feedstock/blob/master/LICENSE.txt)

Summary: Meta-package for Oracle JDK

Development: https://github.com/phreed/oracle-jdk-feedstock

Documentation: https://github.com/phreed/oracle-jdk-feedstock

This module provides a dummy installer for the Oracle JDK.
It does not install the Oracle JDK package.
It adds the Oracle JDK into the specified Conda environment.
It expects the appropriate Oracle JDK to have been previously acquired.
It may be acquired and installed from
https://www.oracle.com/java/technologies/downloads/#java8-windows
https://www.oracle.com/java/technologies/downloads/#java8-linux


Current build status
====================


<table>
</table>

Current release info
====================

| Name | Downloads | Version | Platforms |
| --- | --- | --- | --- |
| [![Conda Recipe](https://img.shields.io/badge/recipe-oracle--jdk-green.svg)](https://anaconda.org/mesomorph/oracle-jdk) | [![Conda Downloads](https://img.shields.io/conda/dn/mesomorph/oracle-jdk.svg)](https://anaconda.org/mesomorph/oracle-jdk) | [![Conda Version](https://img.shields.io/conda/vn/mesomorph/oracle-jdk.svg)](https://anaconda.org/mesomorph/oracle-jdk) | [![Conda Platforms](https://img.shields.io/conda/pn/mesomorph/oracle-jdk.svg)](https://anaconda.org/mesomorph/oracle-jdk) |

Installing oracle-jdk
=====================

Installing `oracle-jdk` from the `mesomorph` channel can be achieved by adding `mesomorph` to your channels with:

```
conda config --add channels mesomorph
conda config --set channel_priority strict
```

Once the `mesomorph` channel has been enabled, `oracle-jdk` can be installed with `conda`:

```
conda install oracle-jdk
```

or with `mamba`:

```
mamba install oracle-jdk
```

It is possible to list all of the versions of `oracle-jdk` available on your platform with `conda`:

```
conda search oracle-jdk --channel mesomorph
```

or with `mamba`:

```
mamba search oracle-jdk --channel mesomorph
```

Alternatively, `mamba repoquery` may provide more information:

```
# Search all versions available on your platform:
mamba repoquery search oracle-jdk --channel mesomorph

# List packages depending on `oracle-jdk`:
mamba repoquery whoneeds oracle-jdk --channel mesomorph

# List dependencies of `oracle-jdk`:
mamba repoquery depends oracle-jdk --channel mesomorph
```




Updating oracle-jdk-feedstock
=============================

If you would like to improve the oracle-jdk recipe or build a new
package version, please fork this repository and submit a PR. Upon submission,
your changes will be run on the appropriate platforms to give the reviewer an
opportunity to confirm that the changes result in a successful build. Once
merged, the recipe will be re-built and uploaded automatically to the
`mesomorph` channel, whereupon the built conda packages will be available for
everybody to install and use from the `mesomorph` channel.
Note that all branches in the phreed/oracle-jdk-feedstock are
immediately built and any created packages are uploaded, so PRs should be based
on branches in forks and branches in the main repository should only be used to
build distinct package versions.

In order to produce a uniquely identifiable distribution:
 * If the version of a package **is not** being increased, please add or increase
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string).
 * If the version of a package **is** being increased, please remember to return
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string)
   back to 0.

Feedstock Maintainers
=====================

* [@phreed](https://github.com/phreed/)

