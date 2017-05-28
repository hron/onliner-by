FROM ruby:latest

ENV BUNDLE_APP_CONFIG /app/.bundle

ENV APT_REFRESHED_ON 2017-05-28
RUN apt-get update

RUN apt-get install -y qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x
RUN apt-get install -y xvfb

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD onliner-by.gemspec /app/onliner-by.gemspec
ADD lib/onliner_by/version.rb /app/lib/onliner_by/version.rb
RUN bundle install


# This part is only required for IDE integration
RUN gem install ruby-debug-ide debase

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "export GEM_HOME=/usr/local/bundle" >> /etc/environment
RUN echo "export BUNDLE_SILENCE_ROOT_WARNING=1" >> /etc/environment
RUN echo "export BUNDLE_APP_CONFIG=$GEM_HOME" >> /etc/environment
RUN echo "export BUNDLE_BIN=$GEM_HOME/bin" >> /etc/environment
RUN echo "export BUNDLE_PATH=$GEM_HOME" >> /etc/environment
RUN echo "export BUNDLE_APP_CONFIG=/app/.bundle" >> /etc/environment
RUN echo "export PATH=$BUNDLE_BIN:$PATH" >> /etc/environment

ENV RUBYLIB "$RUBYLIB:/root/.rubymine_helpers/rb/testing/patch/common:/root/.rubymine_helpers/rb/testing/patch/bdd:/root/.rubymine_helpers/rb/testing/patch/testunit"

EXPOSE 30022

CMD ["/usr/sbin/sshd", "-D"]
