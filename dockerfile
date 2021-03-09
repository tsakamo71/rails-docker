FROM centos:centos7

WORKDIR /

RUN echo 'alias ls="ls -al"' >> ~/.bashrc

RUN yum -y update
RUN yum -y install gcc gcc-c++ git tar openssl openssl-devel bzip2 readline-devel zip unzip sqlite-devel postgresql-devel

# rbenvのインストール
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

# node.jsのインストール
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash -
RUN yum -y install nodejs

# yarnのインストール
RUN curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
RUN rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
RUN yum install -y yarn

# rubyのインストール
ENV CONFIGURE_OPTS --disable-install-doc
ENV RUBY_VERSION 2.6.6
RUN rbenv install ${RUBY_VERSION}
RUN rbenv global ${RUBY_VERSION}

RUN /bin/bash -l -c "gem install bundler"

# kotlinのインストール
#RUN curl -s https://get.sdkman.io | bash
#RUN source /root/.sdkman/bin/sdkman-init.sh
#RUN /bin/bash -l -c "sdk install java;sdk install kotlin;sdk install gradle"

WORKDIR /app
COPY app/Gemfile app/Gemfile.lock /app/
RUN /bin/bash -l -c "bundle install --jobs=4"
