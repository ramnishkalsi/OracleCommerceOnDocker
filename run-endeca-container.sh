docker run -it --user endeca -v /Users/ramnishkalsi/Documents/sonepar/performance:/home/endeca/performance -h localhost -p 8006:8006 -p 8888:8888 -p 15000:15000 -p 15002:15002 -p 15010:15010 ramnishkalsi/endeca:0.5 /bin/bash

# service init-endeca-tools start 
# service init-endeca-ps start 
# service init-endeca-cas start 
