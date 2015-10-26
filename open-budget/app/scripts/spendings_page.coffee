class SpendingsPageView extends Backbone.View

        initialize: ->
            @model.on 'ready-spendings-page', => @render()
            @model.daysLimit.on 'change:value', =>
                @model.newSpendings.fetch(dataType: @model.get('dataType'), reset: true)
                @model.readyEvents.push new ReadyAggregator("ready-spendings-page")
                                                        .addCollection(@model.newSpendings);

        render: ->
            @$el.css('display', 'inherit')
            data =
                exemptions: _.map(@model.newSpendings.models, (x) ->
                    x.toJSON())
                daysLimit: @model.daysLimit.get("value")
            @$el.html window.JST.latest_spending_updates(data)
            
            # Initialize the on click event of the alerts
            $("div.exemption-alert").on("click", (d) =>
                $("div.exemption-alert.selected").removeClass("selected");
                $(d.target).closest("div.exemption-alert").addClass("selected");
                @model.selectedExemption.set("entity_id", $(d.target).closest("div.exemption-alert").attr("entity_id"))
                @model.selectedExemption.set("publication_id", $(d.target).closest("div.exemption-alert").attr("publication_id"))
            );
    
            $("div.exemption-alert:first").trigger("click")

            # Initialize the one change event of the days limit
            $("select#spendings-day-limit").on("change", (d) =>
                @model.daysLimit.set("value", $(d.target).val())
            );


$( ->
    if window.pageModel.get("spendingsPage")?
        window.spendingsPageView = new SpendingsPageView({el: $("#spendings-page-article .latest-updates"), model: window.pageModel});
        window.entityDetails = new EntityDetailsView({el: $("#spendings-page-article .entity-details"), model: window.pageModel});
        window.orphanExemptionPage = new OrphanExemptionView({el: $("#spendings-page-article .orphan-exemption-page"), model:window.pageModel});

)