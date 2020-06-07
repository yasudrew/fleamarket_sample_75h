crumb :root do
  link "FURIMA", root_path
end

crumb :my_page do
  link "マイページ", user_path(current_user.id)
  parent :root
end

crumb :new_profile do
  link '本人確認情報', new_profile_path
  parent :my_page
end

crumb :my_favorites do
  link 'お気に入り', my_favorites_users_path
  parent :my_page
end

crumb :my_items do
  link '出品した商品', my_items_users_path
  parent :my_page
end

crumb :my_purchased_items do
  link '購入した商品', my_purchased_items_users_path
  parent :my_page
end

crumb :new_card do
  link '支払い方法', new_card_path
  parent :my_page
end

crumb :my_card do
  link '支払い方法', card_path(current_user.id)
  parent :my_page
end

crumb :logout do
  link 'ログアウト', logout_path
  parent :my_page
end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).