#!/bin/bash

directories=(
  "lib/app"
  "lib/core/constants"
  "lib/core/exceptions"
  "lib/core/services"
  "lib/core/utils"
  "lib/data/models"
  "lib/data/repositories"
  "lib/data/datasources"
  "lib/presentation/screens/auth"
  "lib/presentation/screens/admin"
  "lib/presentation/screens/student"
  "lib/presentation/screens/shared"
  "lib/presentation/widgets/common"
  "lib/presentation/widgets/course"
  "lib/presentation/widgets/chat"
  "lib/presentation/widgets/admin"
  "lib/presentation/cubit/auth"
  "lib/presentation/cubit/course"
  "lib/presentation/cubit/chatbot"
  "lib/presentation/cubit/user"
  "lib/presentation/cubit/progress"
)

files=(
  "lib/main.dart"
  "lib/app/app.dart"
  "lib/app/routes.dart"
  "lib/app/theme.dart"
  "lib/core/constants/api_constants.dart"
  "lib/core/constants/app_constants.dart"
  "lib/core/exceptions/app_exception.dart"
  "lib/core/exceptions/network_exception.dart"
  "lib/core/services/api_service.dart"
  "lib/core/services/auth_service.dart"
  "lib/core/services/storage_service.dart"
  "lib/core/services/supabase_service.dart"
  "lib/core/utils/validators.dart"
  "lib/core/utils/extensions.dart"
  "lib/data/models/course.dart"
  "lib/data/models/user.dart"
  "lib/data/models/progress.dart"
  "lib/data/models/chat_message.dart"
  "lib/data/repositories/auth_repository.dart"
  "lib/data/repositories/course_repository.dart"
  "lib/data/repositories/user_repository.dart"
  "lib/data/repositories/chat_repository.dart"
  "lib/data/datasources/local_datasource.dart"
  "lib/data/datasources/remote_datasource.dart"
)

for dir in "${directories[@]}"; do
  mkdir -p "$dir"
done

for file in "${files[@]}"; do
  touch "$file"
done

echo "Project structure generated successfully!"