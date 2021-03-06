# ImmutableGraph

[![CI Linux](https://github.com/horothesun/ImmutableGraph/workflows/CI%20Linux/badge.svg)](https://github.com/horothesun/ImmutableGraph/blob/master/.github/workflows/ci-linux.yml)
[![CI macOS](https://github.com/horothesun/ImmutableGraph/workflows/CI%20macOS/badge.svg)](https://github.com/horothesun/ImmutableGraph/blob/master/.github/workflows/ci-macos.yml)
[![codecov](https://codecov.io/gh/horothesun/ImmutableGraph/branch/master/graph/badge.svg?token=Z60dMMK1Lp)](https://codecov.io/gh/horothesun/ImmutableGraph)

[![SwiftPM](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/ImmutableGraph.svg?style=flat)](http://cocoapods.org/pods/ImmutableGraph)
[![Platform](https://img.shields.io/cocoapods/p/ImmutableGraph.svg?style=flat)](http://cocoapods.org/pods/ImmutableGraph)

[![License](https://img.shields.io/cocoapods/l/ImmutableGraph.svg?style=flat)](http://cocoapods.org/pods/ImmutableGraph)

## Examples

Directed graph:

```swift
let u = "☝️", v = "✌️"
let vertices = Set(arrayLiteral: u, v)

let e = Edge(source: u, destination: v)
let edges = Set(arrayLiteral: e)

let graph = Graph(vertices: vertices, edges: edges)
```

Weighted directed graph:

```swift
let w_e = WeightedEdge(source: u, destination: v, weight: 3.9)
let weightedEdges = Set(arrayLiteral: w_e)

let weightedGraph = Graph(vertices: vertices, edges: weightedEdges)
```

DFS from source:

```swift
let simpleGraphAnnotation = dfs(graph, source: v)
```

DFS on graph:

```swift
let simpleGraphAnnotation = dfs(graph)
```

BFS from source:

```swift
let simpleGraphAnnotation = bfs(graph, source: v)
```

Finding paths from graph annotations:

```swift
let parentByVertex = simpleGraphAnnotation.parentByVertex
let result = findPath(parentByVertex: parentByVertex, source: s, destination: d)
```

## CocoaPods installation

`ImmutableGraph` is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your `Podfile`:

```ruby
pod "ImmutableGraph"
```

## Swift Package installation

If your package depends on `ImmutableGraph`, add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/horothesun/ImmutableGraph", .upToNextMinor(from: "0.1.0"))
]
```

## Generate Xcode project

```bash
swift package generate-xcodeproj
```

## Testing

### macOS

```bash
swift test
```

### Docker Linux

IMPORTANT: regenerate Linux test list executing

```bash
swift test --generate-linuxmain
```

Execute on base `swift:5.2` image

```bash
docker run --rm \
    --volume "$(pwd):/package" \
    --workdir '/package' \
    swift:5.2 \
    /bin/bash -c 'swift test'
```

or create a new image based on `Dockerfile` and run it

```bash
docker build --tag immutable-graph .
docker run --rm immutable-graph
```

## Notes

This library was built using TDD.

Some of the graphs used to unit test BFS and DFS algorithms come from [Algorithms with Attitude](https://www.youtube.com/channel/UCUGQA2H6AXFolADHf9mBb4Q) YouTube channel's related videos:

* [Graphs: Breadth First Search (BFS) with Example](https://www.youtube.com/watch?v=ls4cHglfc0g)
* [Graphs: Depth First Search (DFS) with Example](https://www.youtube.com/watch?v=qH-mHxkoK0Q)

## Author

Nicola Di Pol, horothesun@gmail.com


## License

`ImmutableGraph` is available under the MIT license. See the LICENSE file for more info.
