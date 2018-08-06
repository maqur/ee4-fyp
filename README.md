# Formal Verification of POETS applications using TLA+

This project was about exploring the feasibility of TLA+ for formally verifying [POETS](https://poets-project.org/) applications. For this three different POETS applications, namely GalsHeat, GalsIzhikevich and Storm, were specified in TLA+ and verified using the TLC model checker.

## Installation

The specifications can be model checked either using either the [TLA Toolbox](http://lamport.azurewebsites.net/tla/toolbox.html) (IDE) or [TLA+ Tools](http://lamport.azurewebsites.net/tla/tools.html) (CLI) and the official installation instructions are provided on the respective links.

### Docker Image

For a quick setup a docker image has been provided with the TLA+ Tools installed.

` # docker pull maqur/tlaplus-tools `

` # docker run -it maqur/tlaplus-tools `

The TLA+ Tools provide 4 tools, namely [The SANY Syntactic Analyzer](http://lamport.azurewebsites.net/tla/sany.html), [TLC](), [The PlusCal Translator](http://lamport.azurewebsites.net/tla/pluscal.html) and [TLATeX](http://lamport.azurewebsites.net/tla/tlatex.html), which can be accessed using the commands `sany`, `tlc`, `pcal` and `tla2tex` respectively.


<!-- This project was about exploring the feasibility of TLA+ for formally verifying [POETS](https://poets-project.org/) applications. For this three different POETS applications, namely [GalsHeat](./specs/galsHeat/README.md), [GalsIzhikevich](./specs/galsIzhikevich/README.md) and [Storm](./specs/storm/README.md), were specified in TLA+ and verified using the TLC model checker. -->