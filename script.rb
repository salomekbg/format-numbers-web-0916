  class Script
    attr_reader :repo_name, :github_user_name

    def initialize(repo_name, github_user_name) 
      @repo_name = repo_name
      @github_user_name = github_user_name
    end

    def self.run(repo_name, github_user_name)
      new(repo_name, github_user_name).execute
    end 

    def execute
      save_solution_code
      make_new_master_branch
      make_new_solution_branch
      switch_default_branch("new-master")
      `git checkout new-master`
      delete_remote_and_locally("master")
      delete_remote_and_locally("solution")
      make_final_master_branch
      make_final_solution_branch
      switch_default_branch("master")
      `git checkout master`
      delete_remote_and_locally("new-master")
      delete_remote_and_locally("new-solution")
      delete_temp_folder
    end

    def save_solution_code
      `git checkout solution`
      `mkdir ../temp-#{repo_name}`
      `cp -a ./* ../temp-#{repo_name}/`
    end

    def make_new_branch(initial_location, new_branch_name)
      `git checkout #{initial_location}`
      `git checkout -b #{new_branch_name}`
    end

    def make_new_master_branch
      make_new_branch("master", "new-master")
      File.open("README.md", "a") do |f|
        f << "\n"
      end
      `git add README.md`
      `git commit -m "attempt to fix broken build in curriculum by adding whitespace"`
      `git push origin new-master`
    end

    def make_new_solution_branch
      make_new_branch("new-master", "new-solution")
      `rm -rf *`
      `cp -a ../temp-#{repo_name}/. ./`
      `git commit -m "add solution code"`
      `git push origin new-solution`
    end

    def delete_remote_and_locally(branch_name)
      `git push origin :#{branch_name}`
      `git branch -D #{branch_name}`
    end

    def delete_temp_folder
      `rm -rf ../temp-#{repo_name}/`
    end

    def switch_default_branch(branch_name)
      `curl -u #{github_user_name} \
       -d '{"name": "#{repo_name}", "default_branch": "#{branch_name}"' \
       https://api.github.com/repos/flatiron-school-curriculum/#{repo_name}`
    end

    def make_final_master_branch
      make_new_branch("new-master", "master")
      `git push origin master`
    end

    def make_final_solution_branch
      make_new_branch("new-solution", "solution")
      `git push origin solution`
      `git checkout solution`
    end

  end

  Script.run("format-numbers", "kthffmn")