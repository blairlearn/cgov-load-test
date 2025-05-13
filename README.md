# CancerGov Load Tester

Uses a containerized instance of [Apache JMeter](https://jmeter.apache.org/) to generate traffic against
a selected instance of the CancerGov Digital Platform.

## How to run

From the repository root, launch `run.sh`.  This launches JMeter in a batch mode.

Alternatively, if you have JMeter and an appropriate Java version installed, you can run `gui.sh` to
launch the interactive GUI for editing the test plan.

### Evaluating outputs

In addition to generating traffic, the test plan also verifies that the returned content matches expectations.

The key thing to review is results/assertions.txt.  The second column is a boolean value reflecting whether a given
path matched expectations.

Note that the Size assertion is presently disabled as it doesn't report the size of the content body reliably.
The MD5Hex assertion is, so far, reliable.


## Configuration

Paths to generate traffic against are listed in `data-files/url-list.csv`.

There are two configuration points in `config/config.properties`.

- `protocol` - `https` vs. `http`.  You'll generally only use `http` when running against local development.
- `host` - This is the fully-qualified hostname to run against (e.g. www-dev-acsf.cancer.gov)

## TODO

Figure out what sort of reporting we want.  For now, this is just traffic generation.