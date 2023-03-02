class Permission < ApplicationRecord
    has_many :permissions_roles, class_name: "PermissionsRole"
end
