class TeamsController < ApplicationController
  def index
    @sessions = Event.all
  end

  def generate_teams
    event = Event.find(params[:event_id])
    event.teams.destroy_all
    return redirect_to event_path(event), alert: 'Not enough players' unless User.count >= event.teams_count

    players_per_team = User.count / event.teams_count
    user_ids = User.ids.shuffle

    event.teams_count.times do
      team = Team.new
      team.name = Haikunator.haikunate(0, ' ').pluralize.capitalize
      team.user_ids = user_ids.shift(players_per_team)
      event.teams << team
    end

    event.save!
    redirect_to event_path(event)
  end
end
