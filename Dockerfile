FROM python:3.7
MAINTAINER Milan Das "milan.das77@gmail.com"
RUN  apt update -y && apt install net-tools -y
RUN pip install sparkmagic==0.12.9
RUN pip install ipyparallel==6.2.4
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter nbextension install --sys-prefix --py ipyparallel
RUN jupyter nbextension enable --sys-prefix --py ipyparallel
RUN jupyter serverextension enable --sys-prefix --py ipyparallel

WORKDIR /usr/local/lib/python3.7/site-packages
RUN jupyter-kernelspec install sparkmagic/kernels/sparkkernel
RUN jupyter-kernelspec install sparkmagic/kernels/pysparkkernel
RUN mkdir -p  /opt/scripts /home/spark
RUN groupadd -r spark -g 1001 && useradd -r -u 1001 -g spark spark -d /home/spark -s /bin/bash
RUN chown -R spark:spark /opt
RUN chown -R spark:spark /home/spark
USER spark

RUN mkdir -p  /home/spark/.sparkmagic 
COPY config.json /home/spark/.sparkmagic/config.json
COPY shell-scripts/* /opt/scripts
#COPY chmod +x /opt/scripts/run.sh
CMD ["/opt/scripts/run.sh"]

