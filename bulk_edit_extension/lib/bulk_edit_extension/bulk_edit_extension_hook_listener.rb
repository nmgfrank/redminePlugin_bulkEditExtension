require_dependency 'user'

module BulkEditExtension
    class BuilEditExtensionHookListener < Redmine::Hook::ViewListener

        def view_issues_bulk_edit_details_bottom(context={})
            context[:controller].send(:render_to_string, {
                :partial => "hook/bulk_edit_extension/view_issues_bulk_edit_details_bottom",
                :locals => context
            })
        end

        def controller_issues_bulk_edit_before_save(context={})
            params = context[:params]
            issue_info = params[:issue]
            subject_prefix = issue_info['subject_prefix']
            subject_suffix = issue_info['subject_suffix']

            subject_string_rep_from = issue_info['subject_string_rep_from']
            subject_string_rep_to = issue_info['subject_string_rep_to']

            if subject_string_rep_from.class.to_s == "String" and subject_string_rep_to.class.to_s == "String" and subject_string_rep_from.length > 0
                context[:issue].subject = context[:issue].subject.sub(subject_string_rep_from,subject_string_rep_to)
            end
            
            if not subject_prefix.blank?
                context[:issue].subject = subject_prefix + context[:issue].subject
            end
            if not subject_suffix.blank?
                context[:issue].subject = context[:issue].subject + subject_suffix
            end
            
            # bulk add watchers
            watcher_user_ids = issue_info['watcher_user_ids'] || {}
            watcher_user_ids.each do |watcher_id|
                user = User.find_by_id(watcher_id)
                
                if !user.blank?
                    ids = context[:issue].watcher_users.collect {|u| u.id }
                       
                    if !ids.include?  user.id  
                        context[:issue].set_watcher(user)
                    end
                end
               
            end 
       
            
            

        end

    end
end
