import java.io.IOException;
import java.util.StringTokenizer;
import java.util.Vector;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;

public class HeapEaterMapRed {

  public static class TokenizerMapper
  extends Mapper<Object, Text, Text, IntWritable>{

    private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();

    public void map(Object key, Text value, Context context
        ) throws IOException, InterruptedException {
      Vector<byte[]> v = new Vector<byte[]>();
      StringTokenizer itr = new StringTokenizer(value.toString());
      word.set(itr.nextToken());
      while (true) {
        context.write(word, one);
        byte b[] = new byte[1048576];
        v.add(b);
        Runtime rt = Runtime.getRuntime();
        System.out.println( "Free memory: " + rt.freeMemory() + "\t Total memory: " + rt.totalMemory() +"\t Used memory: " + (rt.totalMemory()-rt.freeMemory()) );
      }
    }
  }

  public static class IntSumReducer
  extends Reducer<Text,IntWritable,Text,IntWritable> {
    private IntWritable result = new IntWritable();

    public void reduce(Text key, Iterable<IntWritable> values,
        Context context
        ) throws IOException, InterruptedException {
      int sum = 0;
      for (IntWritable val : values) {
        sum += val.get();
      }
      result.set(sum);
      Vector<byte[]> v = new Vector<byte[]>();
      while (true) {
        context.write(key, result);
        byte b[] = new byte[1048576];
        v.add(b);
        Runtime rt = Runtime.getRuntime();
        System.out.println( "Free memory: " + rt.freeMemory() + "\t Total memory: " + rt.totalMemory() +"\t Used memory: " + (rt.totalMemory()-rt.freeMemory()) );
      }
    }
  }

  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    Job job = Job.getInstance(conf, "word count");
    job.setJarByClass(HeapEaterMapRed.class);
    job.setMapperClass(TokenizerMapper.class);
    job.setCombinerClass(IntSumReducer.class);
    job.setReducerClass(IntSumReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
    TextInputFormat.addInputPath(job, new Path(args[0]));
    TextOutputFormat.setOutputPath(job, new Path(args[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
