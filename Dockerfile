FROM python:3.7
MAINTAINER Milan Das "milan.das77@gmail.com"
RUN pip install sparkmagic==0.12.9
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
WORKDIR /usr/local/lib/python3.7/site-packages
RUN jupyter-kernelspec install sparkmagic/kernels/sparkkernel
RUN jupyter-kernelspec install sparkmagic/kernels/pysparkkernel
RUN mkdir -p  /opt/scripts /home/spark
RUN groupadd -r spark -g 1001 && useradd -r -u 1001 -g spark spark -d /home/spark -s /bin/bash
RUN chown -R spark:spark /opt
RUN chown -R spark:spark /home/spark
USER spark

RUN mkdir -p  ~/.sparkmagic 
COPY config.json ~/.sparkmagic
COPY shell-scripts/* /opt/scripts
#COPY chmod +x /opt/scripts/run.sh
CMD ["/opt/scripts/run.sh"]

