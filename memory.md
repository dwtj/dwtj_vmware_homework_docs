I'm pressed for time. I have only given myself one day to work on this, and I
am not at all familiar with this issue.

Idea: try using -target 1.8 to see if the problem arises from bytecode
differences. Nah, it is already using target 1.8. (Bytecode is v52.)

Start by reading [this][graalvm-memory-management] for context

Identify which "section" of memory is different. Is it the Java heap? Or maybe something else. (E.g., `java.nio.DirectByteBuffer`)

If the problem is with the Java heap, then which GC is being used. How is it configured? (E.g., what is the young generation size?)

Try running the application with different GCs

```
native-image --gc=[serial|G1|epsilon]
```

Note that G1 is only available in GraalVM EE.

Note that epsilon is brand new with 21.2. It does not perform any GC.

What is RSS? Where is this number coming from?

What is Java Native Memory Tracking (NMT).

How does memory usage compare between JVM 8/11 and `native-image` 8/11.

Read [GraalVM's VisualVM Page][graalvm-visualvm]

Can GraalVM `--memtracer` help?

I'm reading through the GraalVM "Debugging and Monitoring Tools", but a number
of these aren't relevant.

VisualVM Object Query Language (OQL) Console

I tried just launching `jvisualvm` from GraalVM 21.2.0 Java 11 on my Linux Dev
Laptop, but it consistently immediately segfaulted.

Fortunately, this segfault doesn't happen with the `jvisualvm` provided by
GraalVM 21.2.0 Java 8

But it appears that Heap dump collection (via `-H:+AllowVMInspection`) is only
supported with GraalVM Enterprise Edition, which I don't have a license for.

What about [JDK Flight Recorder][graalvm-jfr-native-image]

I went browsing on the GraalVM documentation website.

RSS means Resident Set Size. This number shows up in `top`.

RSS = Heap size + MetaSpace + OffHeap size

[from here][where-is-my-memory-java]

I want to read the integration test scripts to understand where the RSS data is
coming from. It is coming from `scripts/test.sh`, which calls `ps -o RSS`. It
is collected after letting the test application run for about 3 seconds
(`sleep 3`). I am curious about how this compares to `ps -o SIZE`

I started by trying to get a baseline from the JVM. Using VisualVM, I briefly
compared the memory usage of `webflux-netty` with both GraalVM 21.2.0 Java 8 &
Java 11. In both cases, the application started with about 85 MB and then
drifted upwards slowly.

Manually triggering a GC caused usage to plummet to 20-25 MB.

For Java 11 Metaspace usage was steady at 28 MB.

So, running webflux-netty on these two JVMs didn't seem show our large
discrepancy. So, I'll be studying three cases:

- native image Java 11
- native image Java 8


I'll start by compiling both of thes native images so that I can easily run
and study them.

What is [metaspace][openjdk-wiki-metaspace]?

Native-image build with Java 8
```
Build memory: 6.51GB
Image build time: 91.1s
RSS memory: 73.6M
Image size: 59.6M
Startup time: 0.04 (JVM running for 0.041)
```

```
Build memory: 6.56GB
Image build time: 110.0s
RSS memory: 74.2M
Image size: 59.6M
Startup time: 0.036 (JVM running for 0.037)
```

Native image build with Java 11

```
Build memory: 7.03GB
Image build time: 103.9s
RSS memory: 121.8M
Image size: 61.6M
Startup time: 0.038 (JVM running for 0.039)
```

```
=== Building webflux-netty sample ===
Packaging webflux-netty with Maven
SUCCESS
Testing executable 'webflux-netty'
SUCCESS
Build memory: 7.14GB
Image build time: 86.6s
RSS memory: .9M
Image size: 61.6M
Did not kill process, it ended on it's own
```

This last one is super weird.

KEY: I see the large memory spikes when there is an error. When the port is
already taken.

Is this accidentally spinning up two application instances?

I do recall seeing two spring prompts show up.

---

[graalvm-memory-management]: https://www.graalvm.org/reference-manual/native-image/MemoryManagement/
[graalvm-visualvm]: https://www.graalvm.org/tools/visualvm/
[graalvm-jfr-native-image]: https://www.graalvm.org/reference-manual/native-image/JFR/
[where-is-my-memory-java]: http://trustmeiamadeveloper.com/2016/03/18/where-is-my-memory-java/
[openjdk-wiki-metaspace]: https://wiki.openjdk.java.net/display/HotSpot/Metaspace
