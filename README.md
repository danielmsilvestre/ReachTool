# ReachTool

ReachTool is a MATLAB toolbox for set-based state estimation and reachability analysis of discrete-time linear systems. It implements nine set representations behind one common interface, so you can run them on the same problem and compare their accuracy, computation time, volume and storage.

Each method estimates a set guaranteed to contain the state of

```
x(k+1) = A x(k) + B u(k) + L d(k)
y(k)   = C x(k) + D u(k) + N w(k)
```

given a known input `u`, a measurement `y`, and bounded disturbance `d` and noise `w`.

## Set representations

| Name in `getReachabilityFcns` | Folder in `Reachability Methods/` | Function prefix |
|---|---|---|
| `Intervals` | `Interval Arithmetic` | `interval` |
| `Zonotopes` | `Zonotopes` | `Zonotope` |
| `Polytopes` | `Polytopes` | `Poly` |
| `SVOs` (set-valued observers, using polytopes) | `SVO` | `SVO` |
| `Constrained Zonotopes` | `Constrained Zonotopes` | `CZ` |
| `CCG` (constrained convex generators) | `Constrained Convex Generators` | `CCG` |
| `Ellipsoids` | `Ellipsoids` | `Ellipsoids` |
| `Points` (vertex-based) | `PointBased` | `Points` |
| `AH-Polytopes` | `AH-Poly` | `AH` |

Names are not case sensitive.

## Requirements

- **MATLAB.** Last run on R2025b.
- **Control System Toolbox**, for the models in `System Models/`, which use `ss` and `c2d`.
- **[YALMIP](https://yalmip.github.io/)**, for the `compile` functions and for several `update`, `estimate` and `volume` functions.
- **[Mosek](https://www.mosek.com/)**, the solver most of the code requests from YALMIP. Some calls can fall back to SeDuMi or `quadprog`, but others ask for Mosek only.

Last run with YALMIP R20230609 and Mosek 11.2.

## Installation

Clone the repository and add these four folders to the MATLAB path:

```matlab
for f = {'Reachability Methods','Simulation Functions','System Models','Utility Functions'}
    addpath(genpath(fullfile(pwd, f{1})));
end
```

Run this from the repository root. Leave `Comparisons/` off the path, because it holds standalone scripts and an older implementation.

## Quick start

This example estimates the state of a DC motor speed model with three set representations:

```matlab
% Model and bounds on the initial state, disturbance and noise
system = motorSpeed(struct('J',0.01,'b',0.1,'K',0.01,'R',1,'L',0.5), 0.1);
bounds = {struct('initial',     getSimpleSets('ball', system.n,  1,    inf), ...
                 'disturbance', getSimpleSets('ball', system.nd, 0.01, inf), ...
                 'noise',       getSimpleSets('ball', system.nn, 0.01, inf))};

% Simulate a trajectory that respects those bounds
T = 20;
x = zeros(system.n, T);
u = ones(1, T);
y = zeros(size(system.C,1), T);
x(:,1) = 2*rand(system.n,1) - 1;
d = 0.02*rand(system.nd,T) - 0.01;
w = 0.02*rand(system.nn,T) - 0.01;
y(:,1) = system.C*x(:,1) + system.D*u(:,1) + system.N*w(:,1);
for k = 2:T
    x(:,k) = system.A*x(:,k-1) + system.B*u(:,k-1) + system.L*d(:,k-1);
    y(:,k) = system.C*x(:,k) + system.D*u(:,k) + system.N*w(:,k);
end

% Run the methods and print their final metrics
names = {'Zonotopes','Constrained Zonotopes','CCG'};
methods = getReachabilityFcns(names);
[errors, times, volumes, nbDoubles, X] = ...
    stateEstimationComputation(methods, {x}, {u}, {y}, system, bounds);

for i = 1:numel(names)
    fprintf('%-22s error %.4g, volume %.4g, %d doubles\n', names{i}, ...
        errors(i,1,end), volumes(i,1,end), nbDoubles(i,1,end));
end
```

`stateEstimationComputation` returns arrays indexed by method, bound and time step, and `X{method,bound}{k}` holds each estimated set. Pass several entries in `bounds`, `x`, `u` and `y` to test several uncertainty levels in one call.

## Interface

`getReachabilityFcns(names)` returns a cell array with one struct of function handles per set representation:

| Field | Purpose |
|---|---|
| `overbound(set)` | Build a set in this representation from a simple set such as a norm ball |
| `propagate(system, X, u, D)` | Prediction step: `A X + B u + L D` |
| `update(system, X, u, y, N)` | Measurement update: keep the states consistent with `y` |
| `estimate(X)` | Point estimate from the set |
| `volume(X)` | Volume of the set |
| `space(X)` | Number of doubles used to store the set |
| `linMap` | Linear map |
| `minkowskiSum` | Minkowski sum |
| `compile(X)` | Returns `[F, p]`, a YALMIP constraint set `F` and the point variable `p` |
| `cvxHull`, `subsetCvxHull` | Only for some representations, listed below |

`compile` lets you use a set directly in an optimization problem, for example an MPC constraint.

### Other set operations

Each representation's `setOperations/` folder holds more functions, which you can call directly by name:

| Representation | Linear map and Minkowski sum | Intersection | Convex hull | Other |
|---|---|---|---|---|
| Intervals | Yes | | | `mmr` |
| Zonotopes | Yes | | | `boxZonotope` |
| Polytopes | Yes | `PolyIntersect` | | |
| Constrained Zonotopes | Yes | `CZIntersect` | `CZcvxHull`, `CZsubsetCvxHull` | `ZtoHrep`, `convertCZ2AH` |
| CCG | Yes | `CCGIntersect` | `CCGcvxHull` | |
| Ellipsoids | Yes | | | |
| Points | Yes | `PointsIntersect` | `PointscvxHull` | `removeInnerPoints` |
| AH-Polytopes | Yes | `AHIntersect` | `AHcvxHull`, `AHsubsetCvxHull` | |

The SVO folder has no `setOperations/` folder.

### System structure

`propagate` and `update` read a struct with these fields:

| Field | Meaning |
|---|---|
| `A`, `B`, `C`, `D` | Discrete-time system matrices |
| `L`, `N` | Disturbance and noise input matrices |
| `n` | Number of states |
| `nd`, `nn` | Sizes of the disturbance and noise |

## Included models

`System Models/` has six models. Each is discretized with zero-order hold at sampling time `Ts`:

| Function | System |
|---|---|
| `cruiseControl(parameters, Ts)` | Cruise control |
| `motorSpeed(parameters, Ts)` | DC motor speed |
| `motorPosition(parameters, Ts)` | DC motor position |
| `aircraftPitch([], Ts)` | Aircraft pitch |
| `invertedPendulum(parameters, Ts)` | Inverted pendulum |
| `suspension(parameters, Ts)` | Vehicle suspension |

The header of each file lists its equations and parameters.

## Repository layout

| Folder | Contents |
|---|---|
| `Reachability Methods/` | The set representations |
| `Simulation Functions/` | `getReachabilityFcns`, `getSimpleSets`, `stateEstimationComputation` |
| `System Models/` | Example plants |
| `Utility Functions/` | `VolumeRayShooting`, `randBallPoint`, `cblkdiag`, `e`, and the third-party polytope library |
| `Comparisons/` | Standalone scripts comparing implementation choices |

The scripts in `Comparisons/` are:

- `CCGillustration`: draws CCGs formed by intersecting ellipsoids and polytopes.
- `comparisonHRepvsYalmip`: compares two ways to compute a constrained zonotope's volume.
- `comparisonMRvsLUB`: compares linear maps on intervals stored as midpoint and radius or as lower and upper bounds.
- `CvxHull_UnionHull_vs_RemoveInnerPoints`: compares two ways to compute the convex hull of vertex sets.

## Known limitations

- **Linear models only.** `propagate` and `update` assume known linear dynamics, with no parametric uncertainty.
- **Missing SVO functions.** `getReachabilityFcns` returns handles to `SVOMinkowskiSum` and `SVOLinMap`, which aren't implemented, so calling them fails. `propagate`, `update`, `estimate`, `volume`, `space`, `overbound` and `compile` are unaffected.
- **CCG convex hull.** `CCGcvxHull` exists but isn't in the method struct, so call it directly.
- **Missing example.** The documentation of `stateEstimationComputation` mentions `ExampleStateEstimation.m`, which isn't in the repository. Use the quick start above.
- **Name clash.** `Utility Functions/e.m` defines a function called `e`, which is shadowed by any variable of that name.

## License

ReachTool is released under the GNU General Public License v3.0. See [LICENSE](LICENSE).

`Utility Functions/polytopes_2017_10_04_v1.9/` is third-party code by Matt Jacobson, under the BSD-style license in its `license.txt`.
