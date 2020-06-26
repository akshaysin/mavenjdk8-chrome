FROM maven:3.6.3-jdk-8

# Google Chrome

ARG CHROME_VERSION=83.0.4103.61-1
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update -qqy
RUN apt-get -qqy install google-chrome-stable
RUN rm /etc/apt/sources.list.d/google-chrome.list
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*
RUN sed -i 's/"$HERE\/chrome"/"$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome

# ChromeDriver

ARG CHROME_DRIVER_VERSION=83.0.4103.39
RUN wget -q -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
        && unzip /tmp/chromedriver.zip -d /opt \
        && rm /tmp/chromedriver.zip \
        && mv /opt/chromedriver /opt/chromedriver-$CHROME_DRIVER_VERSION \
        && chmod 755 /opt/chromedriver-$CHROME_DRIVER_VERSION \
        && ln -s /opt/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver
