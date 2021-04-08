# Rubicon-C64

100% Crack of RUBICON C64 D64. Protection rewritten on normal disk.

<img src="https://github.com/Zibri/Rubicon-C64/blob/main/rubicon1.png?raw=true">
<img src="https://github.com/Zibri/Rubicon-C64/blob/main/rubicon2.png?raw=true">
<img src="https://github.com/Zibri/Rubicon-C64/blob/main/rubicon3.png?raw=true">

# To rebuild the original protected disk (and obtain a clean master)

Copy these 2 D64 on the 2 sides of a floppy disk.   
<a href="https://github.com/Zibri/Rubicon-C64/raw/main/Rubicon_Side_A.d64">Side A</a>   
<a href="https://github.com/Zibri/Rubicon-C64/raw/main/Rubicon_Side_B.d64">Side B</a>

Then insert disk on Side A into the drive and:

<a href="https://github.com/Zibri/Rubicon-C64/raw/main/wp.prg">LOAD"WP",8</a>   

RUN

WP.PRG will write the protection track on track #18 <a href="https://github.com/Zibri/Rubicon-C64/raw/main/wp.s">(source code)</a>

# Alternatevely, to copy the protection from the original RUBICON DISK

insert the original rubicon disk.   
Load and run <a href="https://github.com/Zibri/Rubicon-C64/raw/main/rubicopy.prg">RUBICOPY.PRG</a> ONCE. <a href="https://github.com/Zibri/Rubicon-C64/blob/main/rubcopy.s">(source code)</a>   
Insert the disk where you quickcopied RUBICON.   
Load and run <a href="https://github.com/Zibri/Rubicon-C64/raw/main/rubicopy.prg">RUBICOPY.PRG</a>.   

# Result

The result is a perfect master of Rubicon.   
Mission accomplished.

For a detailed description on how I did this, please read:
<a href="https://github.com/Zibri/Rubicon-C64/raw/main/How%20I%20did%20it.txt">How I did it</a>
