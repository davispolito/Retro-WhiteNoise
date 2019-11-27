# Retro-WhiteNoise

As a first project with Retrolinear I developed a true whitenoise generator for the Atmel Architecture


## LFSR
#### Fibonacci LFSR
![LFSR](LFSR-F16.svg)
#### Galois LFSR
![LFSR](LFSR-G16.svg)
The LFSR algorithm utilizes bit shifting and taps (the bits it polls for XOR/XNOR) to create a deterministically random sequence of bits based off the seed (initial state) and feedback function (Galois vs Fibonacci)


## Implementation
In implementing the program on an AtTiny45 I first thought to maintain two seeds and LFSRs switching between them to account for the speed requirements of the system as well as increase the length of the "random" sequence. This resulted in a consistent tone within the white noise which decreased the amount of high frequency content we achieved. 

This issue was determined to be caused by the interrupt systems inherent latency and timing. In order to avoid this issue I decided to program the same logic directly in machine code to avoid unneccasary looping and memory accesses