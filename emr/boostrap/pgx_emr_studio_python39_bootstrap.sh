#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status
sudo mkdir -p /usr/lib/spark/jars
sudo chmod -R 777 /usr/lib/spark/jars

# Define directories
DEST_DIR="/usr/lib/spark/jars"

# Install Python dependencies
echo "Installing Python packages..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
sudo ./aws/install

sudo python3 -m pip install \
    "python-dateutil>=2.8.1,<2.9.0" \
    "numpy>=1.16.5,<1.23.0" \
    "seaborn>=0.12.2" \
    "plotly>=5.18.0" \
    "boto3>=1.28.0" \
    "ec2-metadata" \
    "catboost>=1.2" \
    "matplotlib>=3.7.0" \
    "shap>=0.42.0" \
    "pyarrow>=14.0.1" \
    "fsspec>=2023.12.0" \
    "s3fs>=2023.12.0" \
    "kneed>=0.8.5" \
    jupyterlab \
    "ipywidgets>=7.6.3" \
    "pandas>=1.3.3" \
    "scikit-learn>=1.0" \
    "pandas-profiling>=3.1.1" \
    jupyter-contrib-nbextensions

# Download Apache Spark CatBoost JAR dependencies
echo "Downloading Apache Spark CatBoost JAR dependencies..."
JAR_URLS=(
  "https://repo1.maven.org/maven2/ai/catboost/catboost-spark_3.5_2.12/1.2.7/catboost-spark_3.5_2.12-1.2.7.jar"
  "https://repo1.maven.org/maven2/ai/catboost/catboost-prediction/1.2.7/catboost-prediction-1.2.7.jar"
  "https://repo1.maven.org/maven2/ai/catboost/catboost-common/1.2.7/catboost-common-1.2.7.jar"
  "https://repo1.maven.org/maven2/io/github/classgraph/classgraph/4.8.139/classgraph-4.8.139.jar"
  "https://repo1.maven.org/maven2/ai/catboost/catboost-spark-macros_2.12/1.2.7/catboost-spark-macros_2.12-1.2.7.jar"
)

for url in "${JAR_URLS[@]}"; do
  sudo wget $url -P "$DEST_DIR" || echo "Failed to download $url"
done

# Verify downloads
echo "Verifying JAR installations..."
for url in "${JAR_URLS[@]}"; do
  jar_name=$(basename "$url")
  if [[ -f "$DEST_DIR/$jar_name" ]]; then
    echo "$jar_name installed successfully."
  else
    echo "Failed to install $jar_name." >&2
    exit 1
  fi
done

# Jupyter extensions setup
echo "Setting up Jupyter extensions..."
sudo jupyter contrib nbextension install --system
sudo jupyter nbextension enable autoscroll/main

echo "All installations completed successfully!"