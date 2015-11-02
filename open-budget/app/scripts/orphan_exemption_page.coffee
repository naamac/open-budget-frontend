class OrphanExemptionView extends Backbone.View
        events:
          'click .exemption-expander': 'toggleExemptionDetails'

        initialize: ->
            @model.selectedExemption.on 'change:publication_id', =>
                pid = @model.selectedExemption.get('publication_id')
                @exemption = new models.Exemption(pageModel: window.pageModel, publicationId: pid)
                @exemption.doFetch()
                @exemption.on 'ready', => @render()

        render: ->
            data = @exemption.toJSON()
            console.log data

            data['exemptions_sum'] = 12345
            data['name'] = data['supplier']
            data['kind'] = data['entity_kind']

            @$el.html window.JST.exemption_details( data )
            if @model.selectedExemption.get('entity_id') != ""
                @$el.css('display','none')
            else
                @$el.css('display','inherit')



window.OrphanExemptionView = OrphanExemptionView

