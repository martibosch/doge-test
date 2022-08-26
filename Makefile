########################################################################################

TERRAFORM_DIR := terraform
ENVS := stage prod
VARS_FILENAME := vars.tfvars
DEPLOY_DIR := $(TERRAFORM_DIR)/deploy
META_DIR := $(DEPLOY_DIR)/meta
BASE_DIR := $(DEPLOY_DIR)/base
APP_DIR := $(DEPLOY_DIR)/app
ENV_DIR = $(APP_DIR)/$(ENV)
DEPLOY_DIRS = $(BASE_DIR) $(foreach ENV, $(ENVS), $(ENV_DIR))
TARGET = $(notdir $(DIR))
COMMANDS := plan apply destroy

# init
define INIT_RULE
.PHONY: init-$(TARGET)
init-$(TARGET):
	terraform -chdir="./$(DIR)" init
endef
$(foreach DIR, $(DEPLOY_DIRS), $(eval $(INIT_RULE)))

# plan/apply/destroy
## treat meta separatedly because of `-var-file`
define META_COMMAND_RULE
.PHONY: $(COMMAND)-$(TARGET)
$(COMMAND)-$(TARGET):
	terraform -chdir="./$(META_DIR)" $(COMMAND) -var-file=$(VARS_FILENAME) \
		$(TF_FLAGS)
endef
$(foreach COMMAND, $(COMMANDS),	$(eval $(META_COMMAND_RULE)))

define COMMAND_RULE
.PHONY: $(COMMAND)-$(TARGET)
$(COMMAND)-$(TARGET):
	terraform -chdir="./$(DIR)" $(COMMAND) -var-file=$(VARS_FILENAME) $(TF_FLAGS)
endef
$(foreach DIR, $(DEPLOY_DIRS), $(foreach COMMAND, $(COMMANDS), \
	$(eval $(COMMAND_RULE))))

# clean state
define CLEAN_RULE
.PHONY: clean-$(TARGET)
clean-$(TARGET):
	find $(DIR) -type d -name ".terraform" -exec rm -rf {} +
endef
$(foreach DIR, $(DEPLOY_DIRS), $(eval $(CLEAN_RULE)))
########################################################################################
