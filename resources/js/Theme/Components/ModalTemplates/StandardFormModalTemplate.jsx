import { Fragment } from 'react'
import ActionButton from '../Buttons/ActionButton'
import ModalCloseButton from '../Buttons/ModalCloseButton'
import ProcessingLoader from '../ProcessingLoader'

export default function StandardFormModalTemplate({
  title = '',
  closeForm,
  submit,
  processing = false,
  leftSideNote,
  cancelBtnLabel = 'Cancel',
  submitBtnLabel = 'Submit',
  withoutActions = false,
  headerBody,
  children,
}) {
  return (
    <form
      className="rounded-md shadow-lg"
      encType="multipart/form-data"
      onSubmit={submit}
    >
      <ProcessingLoader visible={processing} />
      <div className="rounded-t-xl px-4 py-2 flex-between gap-6 bg-white dark:bg-[#162231]">
        <p className="text-lg font-bold text-gray-700 text-start dark:text-white">
          {title}
        </p>
        <ModalCloseButton onClick={closeForm} disabled={processing} />
      </div>

      {headerBody}

      <div className="rounded-b-xl p-4 bg-[#F9FAFD] dark:bg-[#121E2D]">
        {children}
        {!withoutActions && (
          <Fragment>
            <hr className="mt-6 mb-4" />
            <div className={`${leftSideNote ? 'flex-between gap-4' : 'flex-end'}`}>
              {leftSideNote && (
                <p className="text-gray-700 dark:text-white">{leftSideNote}</p>
              )}

              <div className="gap-2 flex-end">
                <ActionButton
                  label={cancelBtnLabel}
                  action="cancel"
                  onClick={closeForm}
                  disabled={processing}
                />
                <ActionButton
                  label={submitBtnLabel}
                  type="submit"
                  action="confirm"
                  disabled={processing}
                />
              </div>
            </div>
          </Fragment>
        )}
      </div>
    </form>
  )
}
