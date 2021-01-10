# Examples for Yosys Synthesis and Equivalence Verification

- Yosys is an OpenSource Tool mainly for Synthesis, but also provides equivalence checks

- Comparing two Verilog Designs
- Comparing Verilog against VHDL
  - Using GHDL and ghdl-yosys-plugin

## Examples

### formal

Some testcases to work with equivalence check in Yosys,
some unexpected behavior:

# Overview

| dir/version | equiv result | equiv expected | Name top | Name sub | Impl Top | Impl sub |
| ----------- | ------------ | -------------- | -------- | -------- | -------- | -------- |
| orig        | false        | false          | same     | same     | diff     | same     |
| v1          | true         | false          | same     | same     | same     | diff     |
| v2          | false        | false          | same     | same     | diff     | same     |
| v3          | false        | false          | same     | same     | diff     | same     |
| v4          | true         | false          | same     | same     | same     | diff     |
| v5          | false        | false          | same     | diff     | same     | diff     |
| v6          | false        | true           | same     | diff     | same     | same     |
| v7          | true         | true           | diff     | same     | same     | same     |
| v8          | true         | false          | diff     | same     | same     | diff     |
| v9          | false        | false          | diff     | diff     | same     | diff     |
| v10         | false        | true           | diff     | diff     | same     | same     |
| v11         | false        | true           | same     | instance name only | same | same |

original version diff
```
8c8
< assign n2 = ~n1;
---
> assign n2 = n1;  // z[0] in new.v is different from that in old.v due to this line
11c11
< assign z[1] = a & b;
---
> assign z[1] = a | b;
```

v1 diff (Logical difference in submodule)
```
18c18
< assign c = a & b;
---
> assign c = a | b;
```

v2 diff (logical difference in topmodule)
```
8c8
< assign n2 = ~n1;
---
> assign n2 = n1;  // z[0] in new.v is different from that in old.v due to this line
```

v3 diff (logical difference in topmodule)
```
11c11
< assign z[1] = a & b;
---
> assign z[1] = a | b;
```

v4 diff (mirrored v1)
```
18c18
< assign c = a | b;
---
> assign c = a & b;
```


v5 diff (renamed submodule name, logical difference in submodule)
```
7c7
< middle M1(.a(a), .b(b), .c(n1));
---
> middler M1(.a(a), .b(b), .c(n1));
14c14
< module middle (
---
> module middler (
18c18
< assign c = a | b;
---
> assign c = a & b;
```

v6 diff (renamed submodule name, no logical difference)
```
7c7
< middle M1(.a(a), .b(b), .c(n1));
---
> middler M1(.a(a), .b(b), .c(n1));
14c14
< module middle (
---
> module middler (
```

v7 diff (renamed topmodule)
```
1c1
< module top (
---
> module topper (
```

v8 diff (renamed topmodule, logical difference in submodule)
```
1c1
< module top (
---
> module topper (
18c18
< assign c = a | b;
---
> assign c = a & b;
```

v9 diff (renamed topmodule, renamed submodule, logical difference in submodule)
```
1c1
< module top (
---
> module topper (
7c7
< middle M1(.a(a), .b(b), .c(n1));
---
> middler M1(.a(a), .b(b), .c(n1));
14c14
< module middle (
---
> module middler (
18c18
< assign c = a | b;
---
> assign c = a & b;
```

v10 diff
```
1c1
< module topper (
---
> module top (
7c7
< middler M1(.a(a), .b(b), .c(n1));
---
> middle M1(.a(a), .b(b), .c(n1));
14c14
< module middler (
---
> module middle (
```

v11 diff
```
7c7
< middle M2(.a(a), .b(b), .c(n1));
---
> middle M1(.a(a), .b(b), .c(n1));
```

### synth

Some examples using the Yosys GHDL plugin
