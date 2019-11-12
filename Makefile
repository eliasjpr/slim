PREFIX=/usr/local
INSTALL_DIR=$(PREFIX)/bin
SYSTEM=$(INSTALL_DIR)/slim

OUT_DIR=$(CURDIR)/bin
LIB=$(CURDIR)/lib
SLIM=$(OUT_DIR)/slim
SOURCES=$(shell find src/ -type f -name 'slim.cr')

all: build

build: lib $(SLIM)

unit: lib | migrate
	@crystal spec spec/domain

endpoints: lib | migrate
	@crystal spec spec/domain

lib:
	@shards install

$(SLIM): $(SOURCES) | $(OUT_DIR)
	@echo "Building $(SLIM) in $@"
	@crystal build -o $@ src/slim.cr --no-debug

$(OUT_DIR) $(INSTALL_DIR):
	 @mkdir -p $@

run:
	$(SLIM)

install: build | $(INSTALL_DIR)
	@rm -f $(SYSTEM)
	@cp $(SLIM) $(SYSTEM)

link: build | $(INSTALL_DIR)
	@echo "Symlinking $(SLIM) to $(SYSTEM)"
	@ln -s $(SLIM) $(SYSTEM)

force_link: build | $(INSTALL_DIR)
	@echo "Symlinking $(SLIM) to $(SYSTEM)"
	@ln -sf $(SLIM) $(SYSTEM)

clean:
	rm -rf $(SLIM)

distclean:
	rm -rf $(SLIM) .crystal .shards libs lib

migrate:
	crystal src/db/cli.cr -- clear migrate status
	crystal src/db/cli.cr -- clear migrate

seed:
	crystal src/db/cli.cr -- clear migrate seed

ameba:
	$(OUT_DIR)/ameba