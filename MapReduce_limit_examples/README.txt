The following Java and Python code allows to test limit cases on MapReduce.

  - WordCount.java is a classical example of MapReduce. It takes two arguments : the input file, and a directory to put its results into.

  - HeapEaterMapRed.java is just the same, except its behaviour is to eat, with an infinite loop, all the available space in Java heap.

  - MapReadThirtyDocs.java looks like WordCount too, except it does it 30 times in a row with the same document. It is usefull to launch a heavy job on a Hadoop cluster, and to use 100% of CPU for some time.

  - InfiniteLoop.py is, as its name defines it, just an infinite loop creating an array and adding little elements to it. Its goal is to use as much RAM as possible.

  - RAMEaterMapRed.java is using the Python script defined previously to use as much RAM as possible on the container launching the job. Its goal is to be properly killed by MapReduce application manager.
